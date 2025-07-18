import React from 'react';
import jsx from 'react/jsx-runtime';
import ReactDOM from 'react-dom/client';
import Dashboard from './components/Dashboard';

const app = document.getElementById('app');

if (app) {
    ReactDOM.createRoot(app).render(<Dashboard/>);
}

const adminPanel = document.getElementById('adminPanel');

if (adminPanel) {
    ReactDOM.createRoot(adminPanel).render(<Dashboard/>);
}
