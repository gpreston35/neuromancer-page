import { useState } from 'react';

export default function App() {
  const [mode, setMode] = useState('night');
  const isDay = mode === 'day';

  return (
    <main className={`landing ${isDay ? 'day' : 'night'}`} aria-label="Neuromancer landing page">
      <nav className="side-nav" aria-label="Feature navigation">
        <span className="side-nav__label">Features</span>
        <a href="/openfda/" className="side-nav__link">
          <span>Enforcement Data</span>
          <strong>OpenFDA explorer</strong>
        </a>
      </nav>

      <div className="mode-shell" aria-hidden="true">
        <span className={isDay ? 'sun active' : 'sun'}>☀︎</span>
        <span className={!isDay ? 'moon active' : 'moon'}>☾</span>
      </div>

      <button
        className="toggle"
        type="button"
        aria-pressed={isDay}
        onClick={() => setMode(isDay ? 'night' : 'day')}
      >
        <span>{isDay ? 'Day mode' : 'Night mode'}</span>
        <strong>{isDay ? 'Switch to night' : 'Switch to day'}</strong>
      </button>

      <p className="kicker">{isDay ? 'signal at dawn' : 'signal received'}</p>
      <h1>Brought to you by Neuromancer</h1>
      <p className="subtitle">
        {isDay
          ? 'A tiny React app, glowing in daylight.'
          : 'A tiny React app, freshly summoned.'}
      </p>
    </main>
  );
}
